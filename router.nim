


# type
#   Route*: = ref object
#     path*: string
#     handler*: proc (req: Request) {.async.}
#
# var
#   Routes*:seq[Route] = @[]
#
# Routes.add(Route(
#   path: "/",
#   handler: proc (request: Request) {.async.} =
# ))
#
#

# type
#   Handler: proc (s: string) {.closure.}
#   Route*: ref object
#     path*: string
#

type
  Handler* = proc (s: string) {.closure.}
  Route* = ref object
    path*: string

var
  Routes*: seq[Route] = @[]

proc get(i: string, cb: Handler) =
  Routes.add(Route(
    path: i
  ))
  cb(i)

proc cb(q: string) =
  echo q

get("test here", cb)


get("Another!", proc (ou: string) =
  echo ou, "YESS"
  for k, v in Routes:
    echo v.path
)

