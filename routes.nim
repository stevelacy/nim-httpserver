
type
  Route* = ref object of RootObj
    path*: string
    body*: string

var
  Routes*: seq[Route] = @[]

Routes.add(Route(
  body: readFile("views/index.html"),
  path: "/"
))
Routes.add(Route(body: "test", path: "/test"))

