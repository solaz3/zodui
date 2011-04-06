local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales

------------------------------------------------------------------------
--	Enhance/rewrite a Blizzard feature, chat bindings
------------------------------------------------------------------------

-- key binding header
BINDING_HEADER_KEY = L.chat_bind_header
BINDING_NAME_SAYMESSAGE      	= L.chat_bind_say
BINDING_NAME_YELLMESSAGE      	= L.chat_bind_yell
BINDING_NAME_PARTYMESSAGE     	= L.chat_bind_party
BINDING_NAME_GUILDMESSAGE     	= L.chat_bind_guild
BINDING_NAME_RAIDMESSAGE      	= L.chat_bind_raid
BINDING_NAME_BATTLEGROUND    	= L.chat_bind_bg

function SetChatTo(prefix)
  prefix = "/"..prefix.." "
  if ChatFrame1EditBox:IsVisible() then
    ChatFrame1EditBox:SetText(prefix)
  else
    ChatFrame_OpenChat(prefix)
  end
  ChatEdit_ParseText(ChatFrame1.editBox, 0)
end
