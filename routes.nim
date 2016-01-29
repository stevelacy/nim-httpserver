
type
  Route* = ref object of RootObj
    path*: string
    body*: string

var
  Routes*: seq[Route] = @[]

Routes.add(Route(
  body: "home",
  path: "/"
))
Routes.add(Route(body: "test", path: "/test"))

