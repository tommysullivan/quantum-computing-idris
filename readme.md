quantum-computing
=================

# Development

Develop in the cloud immediately via https://dev.me


dev-me
======

Dev.me just has a webserver that uses the http referer header to find the location of a
repo (readme, specifically) on github, and then interact with that to immediately create
a development environment on the spot.

The system can interact with github teams to allow teams to define shared resources for 
the environment as part of the IAC.

We could just have some specific helm chart or some specific file that in turn contains
a helm chart. A very general one would be to have a dev.me file either in the same dir
as the readme or a parent dir.

Perhapa a specifically named repo can be established to codify the github team level stuff
that doesn't fit into any particular repo, same thing for organization.

Conventions for the dev.me config file:

Ideal Dev Environment
runs on mac
runs in cloud

running on mac

install a local dev.me (in the project folder) and then run it, passing the github clone url,
or if you are in a git repo, just run the dev.me tool

the config file itself refers to the URL of a versioned typescript interface that matches a
semver range / SHA that defines the shape of the configuration file (so it is self
discoverable).

The config file may be written as a json file or a tson file, where the tson file takes the
following form:

{
    "tson@1.0.0": {
        "contentType": "urlOfSemVerInterfaceForThisConfig" //we specifically do not want package.json coupling
        "contentType": "
    }
}

Specific URL format for RESTful Interfaces:
https://host/someInterfaceName?etag=[semVerRangeOrSHA]&contentType=[valid content type string] (human format)

Machine:
GET https://host/someInterfaceName + ETAG http header: [semVerRangeOrSHA]
OPTIONS / HEAD https://host/someInterfaceName  - lists all available ETAGs (versions)







# Tommy Content Types

Sometimes one needs to specify a particular "type" of representation of a remote REST resource identified by
some given URL. To do this, one *should* use content types and "content type negotiation" from the REST specification.

The problem is that the standard content types themselves are limited, not customizable, and not
discoverable, and we have collectively as an industry barely scratched the surface on leveraging
the power of content-type negotiation.

Reminder on what content types are:

application/json
text/plain
text/html
image/jpeg

A given REST resource at one URL may have *many* representations, each one identified by a content type,
and a browser may request a list of all the available content types for a given URL, or may perform a 
GET request on said URL, passing in a list of one or more preferred content types, in decreasing
preference order, from among the available types listed for that particular resource at that URL. (to
list the content types of a resource at a URL, do an OPTIONS or HEAD request on the URL instead of using the GET http method)

One challenge is that today, all content types are "not discoverable" really and must be known "a priori" 
how to be interpreted by the client.

To make it easier to discover the definition of a content type, we embrace the power of the web
and simply use a URL in the content type name itself:

TOMMYTYPE format for MIME TYPES / CONTENT TYPES that embed URLs for purposes of discovery:

application/X-tommytypes;url="https://urlOfSomeContentTypeDefinition"
application/x.tommytypes;url="https://urlOfSomeContentTypeDefinition"
application/vnd.tommytypes;url="https://urlOfSomeContentTypeDefinition"

One may ask, "What do I get if I visit the url of a content type"? Well, that depends
on the content-type used when requesting a representation of the content type resource being
requested!

Let's walk through a use case to understand:

GET https://clams.net/clams/1283712837 (in browser)
ACCEPT: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8 (default chrome browser types)
RESPONSE:
-> return a webpage showing the clam and you never need to know about the typesystem (javascript rich, or plain static html, or even plain text)

OPTIONS https://clams.net/clams/1283712837
CONTENT-TYPES: [list of available content types here, including text/html but also some tommytypes]


1. Someone gives you a URL for a Clam and claims it is RESTful
2. You query the URL to understand it as a resource using OPTIONS, HEAD, or other REFLECTIVE http methods
3. You don't yet know about the type system so the first thing you do is just browse to the URL in your browser
4. The browser therefore sends a default content-type header (as well as other browser headers) to the web server at the URL
5. The response describes all the content types and all the versions (ETAGS)
6. There are two classes of content types, Tommy Content Types (the new ones), and non-tommy content types (the more familiar ones)
7. The types include probably a text/plain description of the content type, an html version of the type (which in turn should either render
   a static html (no javascript) page, or if javascript, a rich type-viewer that can allow the user to explore the web-typesystem from
   his/her browser, but also should include a list of TOMMY TYPES, content types which are likely under application/X-tommytype;url="someURL",
   which are "discoverable types", where one can discover the type itself using the same discovery process we began in step (1)

Thinking of a type itself as an abstract REST Resource with many possible representations (where each representation itself has a content type)

1. Let's pick an example representation of a type: a typescript interface
2. Let's assume it is possible to have a "conceptually equivalent" representation in multiple versions of the typescript language itself, 
   as well as perhaps protobuf (though the formats of a type definition under these regimes can vary wildly, they may have a notion of
   conceptual equivalence)
3. Let's assume there is a single URL for the resource represented by all of these "conceptually equivalent" representations, each
   with their specific format.
4. An OPTIONS request on the URL, then, should return a list of CONTENT TYPES during content type negotiation (a core REST concept that
   is not getting enough love). The content types should correspond to all the formats available for the above resource. But we don't just
   want to make up MIME TYPEs for each of those formats which are not discoverable, and which clients would have to know a priori! That
   is one of the biggest painpoints about REST right now that tools like swagger try to (not quite RESTfully) solve. So, we invent the
   TOMMYTYPE content type to be a consistent way to embed URLs into content type labels themselves, so that each content type is 
   discoverable in an automated and human-friendly way.
5. So, for example, given the URL of the Clam, you do an OPTIONS request on the URL. Without looking at the clam itself, you get back
   a list of the CONTENT TYPES available for viewing a representation of the Clam. Let's now be explicit and say that those were:
   image/jpeg
   image/png
   text/html
   text/plain
   application/json
   text/xml
   application/x.tommytype;url="https://tommysclams.com/tommytypes/Clam?etag=^7.2.42"
6. So you see these generic ways of viewing the clam, and sure maybe you choose one of the well-known ones and do your GET request, 
   sending along that specific well known content type, perhaps text/html, and there is a nice website showing you the clam, tailored
   nicely to your browser / device.
7. But maybe you want to programmatically consume the clam. In the past, there might be a swagger doc that you could read as an html page
   that would explain the methods that you could use and the shape of the body that can be sent / should be expected back. Or you might
   just do a GET requesting application/json and then examine the clam representation to see if you can understand its shape from the
   structure. Thing is, there may be other clams with more detailed structure, so you may not be able to fully comprehend the type. 
9. Nice thing about the tommytypes is you see right there that there is a URL you can click on that will tell you more about the Clam type.
   No special knowledge is needed, a simple browser request will show a nice HTML page explaining the type, and allow one to navigate it
   and its relationships to other types, and different versions of other types, across various languages and formats, all graphed together
   RESTfully on the web. And how would the HTML page do that? After loading a nice viewer, it would simply perform an OPTIONS request
   on its own URL, getting type information about itself, and then presenting that to you as the user.
10. So, we have the URL of the TYPE of clam. So the resource is not a particular CLAM, it is rather a description of a means of *representing*
    a clam - you know, REPRESENTATIONAL state transfer (REST). In other words, a "type". Like any REST resource, this "Clam Type" itself can be
    represented in multiple ways. We already looked at the human readable browser representation of the type in the above bullet; but let's take
    a closer look at whan an OPTIONS call on the "Clam Type" URL would look like:
    text/plain
    text/html
    application/x.tommytype;url="https://microsoft.com/tommytypes/typescript?etag=2.4.0"
    application/x.tommytype;url="https://microsoft.com/tommytypes/typescript?etag=3.0.1"
    application/x.tommytype;url="https://oracle.com/tommytypes/java?etag=8.0"
11. We can now see that the "Clam Type" resource is itself RESTful, having multiple representations, including two typescript representations
    (for two different versions of typescript), and one oracle java 8 representation, as well as human readable representations of what a "Clam Type" is (which could possibly be generated from the programmatic definitions)
12. We can see how an intelligent module system could put together graphs of types and values across multiple versions of languages in 
    a discoverable web, and from there we can imagine building all kinds of new things flexibly, openly, and with far less reword than ever before!


# TSON file format

A .tson file is just a .json file with an extra layer of metadata around it that makes it typecheckable in a discoverable way:

.tson
{
    "http://tommytypes.com/tson?etag=^1.0.0": "https://tommysclams.com/tommytypes/Clam?etag=^7.2.42",
    "hasPearl": true,
    "diameter": 27
}

.tson
[
    {"http://tommytypes.com/tson?etag=^1.0.0": "https://tommysclams.com/tommytypes/Clam?etag=^7.2.42"},
    1,
    2,
    3
]

.tson
7

So, we know there is an abstract schema for the JSON in this document, located at https://tommysclams.com/tommytypes/Clam?etag=^7.2.42. Let's say
that the content types for that URL include a typescript 2 definition (in this case let's imagine a typescript file with an anonymous
default export interface), so we requst https://tommysclams.com/tommytypes/Clam?etag=^7.2.42 using content type
"https://microsoft.com/tommytypes/typescript?etag=2.4.0", and we get back the following:

import * as TSON from "http://tommytypes.com/tson?etag=^1.0.0"

export default interface Clam extends TSON {
    "hasPearl": boolean,
    "diameter": number
}

By the way, if we also requested a content-type "https://microsoft.com/tommytypes/typescript?etag=2.4.0" of the resource at
"http://tommytypes.com/tson?etag=^1.0.0", which in this case is what our specialized typescript module loader would do, it would
get the following typescript interface:

import { URL } from "http://tommytypes.com/url?etag=1.0.0"

export default interface TSON {
    "http://tommytypes.com/tson?etag=^1.0.0": URL
}