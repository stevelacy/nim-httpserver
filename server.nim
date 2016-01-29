import asynchttpserver, asyncdispatch


type
  Route = ref object of RootObj
    path: string
    body: string

var
  Routes: seq[Route] = @[]

Routes.add(Route(
  body: "home",
  path: "/"
))
Routes.add(Route(body: "test", path: "/test"))

# for k, v in Routes:
#   echo v.body, v.path


var server = newAsyncHttpServer()
proc cb(req: Request) {.async.} =
  echo req.reqMethod, " ", req.url.path
  for k, v in Routes:
    if v.path != req.url.path: continue
    await req.respond(Http200, v.body)

  await req.respond(Http404, "404 - not found")

waitFor server.serve(Port(8080), cb)
