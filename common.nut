function toJSON(Table) {
  if(typeof(Table)!="array" && typeof(Table)!="table")
    return Table.tostring();
  local Out = "";
  function AsString(Item) {
    switch(typeof(Item)) {
      case "table":
      case "array":
        return ToJSON(Item);
      case "string":
        local Len = Item.len();
        local Str = "";
        for(local i=0;i<Len;i++) {
          if(Item[i]=='\\' || Item[i]=='\"')
            Str+="\\";
          Str+=format("%c", Item[i])
        }
        return "\""+Str+"\"";
      default:
        return Item.tostring();
    }
  }
  if(typeof(Table) == "table") {
    if(Table.len() == 0) return "{}";
    Out = "{";
    foreach(Key,Val in Table)
      Out += "\""+Key+"\":"+AsString(Val)+", ";
    return Out.slice(0,-2) + "}";
  }
  if(typeof(Table) == "array") {
    if(Table.len() == 0) return "[]";
    Out = "[";
    foreach(Val in Table)
      Out += AsString(Val)+", ";
    return Out.slice(0,-2) + "]";
  }
}
