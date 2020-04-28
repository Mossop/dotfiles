def prun
  tbreak main
  run
  set auto-solib-add 0
end

# define "pu" command to display PRUnichar * strings (100 chars max)
def pu
  set $uni = $arg0 
  set $i = 0
  while (*$uni && $i++<100)
    if (*$uni < 0x80) 
      print *(char*)$uni++
    else
      print /x *(short*)$uni++
    end
  end
end

# define "ps" command to display nsString/nsAString
def ps
  pu $arg0->mData
end

# define "pcs" command to display nsCString/nsACString
def pcs
  print $arg0->mData
end

def jsstack
  call DumpJSStack()
end
