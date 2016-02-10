import os, strutils, asynchttpserver, asyncdispatch, mimetypes

proc serveStatic*(req: Request) {.async.} =
  echo req.reqMethod, " ", req.url.path
  let path = "./$1" % req.url.path

# TODO:
  let mimetype = getMimetype(newMimeTypes(), replace(splitFile(path).ext, ".", ""))

  if existsFile(path):
    try:
      let file = readFile(path)
      await req.respond(Http200, file)
    except:
      echo "io error"
    await req.respond(Http500, "Error")
  else:
    let msg = "Can't $1 $2 " % [req.reqMethod, req.url.path]
    await req.respond(Http404, msg)

