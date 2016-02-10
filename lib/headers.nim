import asynchttpserver, strtabs

proc createHeaders*(status: HttpCode, mime: string, length: int): StringTableRef =
  let headers = newStringTable({
    "Content-Type": mime,
    "Content-Length": $length
  })
  return headers

