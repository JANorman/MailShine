MailShine
=========

MailShine is a RESTful web service that can perform post processing to emails you send from your application. It uses the great [Premailer](https://github.com/premailer/premailer/) libraries, wrapped by a RESTful API, and containerized in Docker container.

## Installation

#####Clone the repository
````
git clone git@github.com:JANorman/MailShine.git
cd MailShine/
````

#####Build the docker container
````
docker build -t janorman/mailshine .
````

#####Run the container
````
docker run -p 45000:4567 -d janorman/mailshine
````

Congratulations, the application should now be running! Read the usage instructions for details on calling the APIs.

##Usage
MailShine is still in development, and currently exposes the current endpoints

#### POST /mail
If you make a POST request to the _/mail_ endpoint, the application will return you a JSON body, which contains the result of inlining the CSS in the body. 

The requests body should be the full HTML body. An example request are response are below.

**Outbound Request**
````
curl -v -X POST -d "<html><head><style type="text/css">.test{ color: red; }</style></head><body><span class="test">Hi</span></body></html>" http://172.17.8.101:45000/mail
````

**Response**
````
* upload completely sent off: 114 out of 114 bytes
* additional stuff not fine transfer.c:1037: 0 0
* HTTP 1.1 or later with persistent connection, pipelining supported
< HTTP/1.1 200 OK
< Content-Type: application/json
< Content-Length: 184
< X-Content-Type-Options: nosniff
< Connection: keep-alive
< Server: thin
````
````json
{
  "result":"<html><head></head><body><span class=\"test\" style=\"color: red;\">Hi</span></body></html>",
  "warnings":[
    {
      "message":"color CSS property",
      "level":"SAFE",
      "clients":"Eudora"
    }
  ]
}
````

