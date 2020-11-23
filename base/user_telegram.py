from telethon import events
import asyncio
from base.functions import  find_button, find_text_from_table
from utiles.logger_file import LogGen

logger = LogGen.loggen()

class User():
    """
    class of user which could make action in telegram:
     - click button
     - send message
     - get message(s)
    ------------------------------
    client - object of TelegramClient()
    bot - name of the bot who you talk to
    """
    def __init__(self, client, bot):
        self.client = client
        self.bot = bot
        self.loop = asyncio.get_event_loop()




    async def get_last_message(self):
        message = await self.client.get_messages(self.bot, limit=1)
        return message[0]

    async def last_messages(self, quantity=2):
        messages = await self.client.get_messages(self.bot, limit=quantity)
        return messages

    async def double_new_waiting (self, conver):
        await conver.wait_event(events.NewMessage(from_users=self.bot))
        try:
            await conver.wait_event(events.NewMessage(from_users=self.bot), timeout=3)
        except:
            pass

    async def double_edit_waiting (self, conver):
        await conver.wait_event(events.MessageEdited(from_users=self.bot))
        try:
            await conver.wait_event(events.MessageEdited(from_users=self.bot), timeout=2)
        except:
            pass

    async def wait_after_action(self):
        async with self.client.conversation(self.bot) as conv:
            edit = asyncio.create_task(self.double_edit_waiting(conv))
            deleted = asyncio.create_task(self.double_new_waiting(conv))
            await asyncio.wait([edit, deleted], return_when='FIRST_COMPLETED')

    async def wait_after_sending_message(self, amount=2):
        async with self.client.conversation(self.bot) as conv:
            for i in range(amount):
                try:
                    await conv.wait_event(events.NewMessage(from_users=self.bot))
                except:
                    logger.error("could not wait")
    async def async_click_button(self, tex, mess = 2):
        messages = await self.last_messages(quantity=mess)
        button = find_button(messages, tex)
        message = self.get_last_message()
        event = button.click()
        await asyncio.wait({event, message},return_when='FIRST_COMPLETED' )
        await self.wait_after_action()

    async def async_send_message(self, message):
        await self.client.send_message(self.bot, message)
        await self.wait_after_action()

    async def async_get_message(self):
        message = await self.get_last_message()
        self.message = message.text

    async def async_get_messages(self, n):
        messages = await self.last_messages(quantity=n)
        self.messages = messages

    async def async_check_message(self, search_text, mess_quant=2):
        messages = await self.last_messages(quantity=mess_quant)
        self.check_text = False
        for message in messages:
            if search_text in message.text:
                self.check_text = True
                return

    async def async_check_message_code(self, code):
        messages = await self.last_messages()
        self.check_text = False
        search_text = find_text_from_table(int(code))
        for message in messages:
            if search_text in message.text:
                self.check_text = True
                return

    async def async_get_profile_fl_name_username(self):
        profile = await self.client.get_me()
        username = '(@' + profile.username + ')' if profile.username else '()'
        first_name = profile.first_name + ' ' if profile.first_name else ''
        last_name = profile.last_name + ' ' if profile.last_name else ''
        self.profile_data = first_name + last_name + username

    async def async_button_is_disappeared(self, button_name, mess_quant):
        messages = await self.last_messages(quantity=mess_quant)
        button = find_button(messages, button_name)
        self.check_disappeared_button = True if button == None else False

    async def async_immutable_after_click(self, button_name, mess_quant):
        messages = await self.last_messages(quantity=mess_quant)
        button = find_button(messages, button_name)
        message_before = messages[0].text
        """click the button"""
        cork = self.get_last_message()
        event = button.click()
        await asyncio.wait({event, cork}, return_when='FIRST_COMPLETED')
        """------------------------------------------------------------"""
        await asyncio.sleep(2)
        messages = await self.last_messages(quantity=mess_quant)
        message_after = messages[0].text
        self.immutable_after_click_result = True if message_before==message_after else False



    """functions for step files"""
    def click_button(self, tex, mess_quant=2):
        with self.client:
            self.client.loop.run_until_complete(self.async_click_button(tex, mess_quant))

    def send_message(self, message_text):
        with self.client:
            self.client.loop.run_until_complete(self.async_send_message(message_text))

    def get_message(self):
        with self.client:
            self.client.loop.run_until_complete(self.async_get_message())
        return self.message

    def get_messages(self, n=2 ):
        with self.client:
            self.client.loop.run_until_complete(self.async_get_messages(n))
            return self.messages

    def check_message(self, search_text,mess_quant=2):
        with self.client:
            self.client.loop.run_until_complete(self.async_check_message(search_text, mess_quant=mess_quant))
        return self.check_text

    def check_message_code(self, code):
        with self.client:
            self.client.loop.run_until_complete(self.async_check_message_code(code))
        return self.check_text

    def get_profile_fl_name_username(self):
        """" gives first? last name and username of user"""
        with self.client:
            self.client.loop.run_until_complete(self.async_get_profile_fl_name_username())
        return self.profile_data

    def button_is_disappeared(self, button_name, mess_quant=2):
        with self.client:
            self.client.loop.run_until_complete(self.async_button_is_disappeared(button_name, mess_quant=mess_quant))
        return self.check_disappeared_button

    def immutable_after_click(self, button_name, mess_quant=2):
        with self.client:
            self.client.loop.run_until_complete(self.async_immutable_after_click(button_name, mess_quant=mess_quant))
        return self.immutable_after_click_result

