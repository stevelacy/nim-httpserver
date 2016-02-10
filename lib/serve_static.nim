import os, strutils, asynchttpserver, asyncdispatch, mimetypes, strtabs
import lib/headers

proc serveStatic*(req: Request, root: string = "./") {.async.} =
  echo req.reqMethod, " ", req.url.path
  let path = "$1/$2" % [root, req.url.path]

  let mimetype = getMimetype(newMimeTypes(), replace(splitFile(path).ext, ".", ""))

  if existsFile(path):
    try:
      let file = readFile(path)
      let headers = createHeaders(Http200, mimetype, file.len)
      await req.respond(Http200, file, headers)
    except:
      echo "io error"
    await req.respond(Http500, "Error")
  else:
    let msg = "Can't $1 $2 " % [req.reqMethod, req.url.path]
    await req.respond(Http404, msg)

