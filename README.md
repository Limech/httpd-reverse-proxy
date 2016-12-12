

# Introduction

This Dockerfile helps generate an Apache HTTP Server image that can easily be deployed as a reverse-proxy in front of multiple sites.

Currently all traffic will be forced on port 443 over HTTPS using the self-signed certificate generated on Apache Web Server installation.

The forwarding settings are baked in the image at Docker build time.
The `gen-proxies.py` file generates the needed configuration settings to support the sub-folder to target mappings identified in the `sites.json` file.

## Format of sites.json file

The file is in json format with the following structure:
```json
[
    ["/sub1/",  "http://{myip:port}/"              ],
    ["/sub2/",  "http://{mydomain:port/subpath}/"  ],
    ["/",       "http://localhost/"                ]   
]
```
The JSON must contain an array of arrays with two entries in them.
The first entry is the subpath used by your entry point.  The second entry is the destination address behind the proxy that the traffic should be redirected to/from.

Note that the reverse-proxy only modified HTML header information to camouflage the origin of the traffic.
All HTML and JavaScript being returned should be such that the URL resolves properly.
I.e. if all URLs are formed dynamically using relative paths then there will be no issue.
However, all absolute paths used should reflect how an external browser outside the reverse-proxy would access that resource.

An example file called `sites-example.json` is provided as example.
The actual file must be called `sites.json`.

## Building the image

Building the image can be achieved using the following command from within the folder where the `Dockerfile` resides:

    docker build --build-arg serverName=mydomain.com -t imageName .

Since the site list lookups are baked into the image, any changes to the list will require a new image to be built to update.

## Running an instance of the container

An instance of the reverse-proxy can be run using:

    docker run -d -p 80:80 -p 443:443 --name containerName <imageName>

 




