import asynchttpserver, asyncdispatch, os, strutils
import routes, lib/serve_static

var server = newAsyncHttpServer()
# proc cb(req: Request) {.async.} =
#   echo req.reqMethod, " ", req.url.path
#   for k, v in Routes:
#     if v.path != req.url.path: continue
#     await req.respond(Http200, v.body)
#
#   await req.respond(Http404, "404 - not found")
#

proc Debussy*(req: Request): Future[void] =
  serveStatic req

waitFor server.serve(Port 8080, Debussy)

