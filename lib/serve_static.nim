import os, asynchttpserver, asyncdispatch, mimetypes, strtabs
import lib/headers

proc serveStatic*(req: Request, root: string = "./") {.async.} =
  echo req.reqMethod, " ", req.url.path
  let path = root & "/" & req.url.path
  let ext = splitFile(path).ext[1 .. splitFile(path).ext.len-1]
  let mimetype = getMimetype(newMimeTypes(), ext)

  if existsFile(path):
    try:
      let file = readFile(path)
      let headers = createHeaders(Http200, mimetype, file.len)
      await req.respond(Http200, file, headers)
    except:
      echo "io error"
    await req.respond(Http500, "Error")
  else:
    let msg = "Can't " & req.reqMethod & " " & req.url.path
    await req.respond(Http404, msg)

