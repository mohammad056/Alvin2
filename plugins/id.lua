do

function run(msg, matches)
  return "👤Name : "..(msg.from.print_name or '').."\n🆔user ID : "..msg.from.id.."\n\n👥Group name : "..msg.to.title.."\n🆔Group ID : "..msg.to.id
end
return {
  description = "", 
  usage = "",
  patterns = {
    "^[!/#]id$",
  },
  run = run
}
end
