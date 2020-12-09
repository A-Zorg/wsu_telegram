from telethon import events
import asyncio
from base.functions import  find_button, find_text_from_table
from utiles.logger_file import LogGen
import re
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

    async def __get_last_message(self):
        message = await self.client.get_messages(self.bot, limit=1)
        return message[0]

    async def __last_messages(self, quantity=2):
        messages = await self.client.get_messages(self.bot, limit=quantity)
        return messages

    async def __double_new_waiting (self, conver):
        await conver.wait_event(events.NewMessage(from_users=self.bot))
        try:
            await conver.wait_event(events.NewMessage(from_users=self.bot), timeout=3)
        except:
            pass

    async def __double_edit_waiting (self, conver):
        await conver.wait_event(events.MessageEdited(from_users=self.bot))
        try:
            await conver.wait_event(events.MessageEdited(from_users=self.bot), timeout=2)
        except:
            pass

    async def __wait_after_action(self):
        async with self.client.conversation(self.bot) as conv:
            edit = asyncio.create_task(self.__double_edit_waiting(conv))
            deleted = asyncio.create_task(self.__double_new_waiting(conv))
            await asyncio.wait([edit, deleted], return_when='FIRST_COMPLETED')

    async def __wait_after_sending_message(self, amount=2):
        async with self.client.conversation(self.bot) as conv:
            for i in range(amount):
                try:
                    await conv.wait_event(events.NewMessage(from_users=self.bot))
                except:
                    logger.error("could not wait")
    async def __async_click_button(self, tex, mess = 2):
        messages = await self.__last_messages(quantity=mess)
        button = find_button(messages, tex)
        message = self.__get_last_message()
        event = button.click()
        await asyncio.wait({event, message},return_when='FIRST_COMPLETED' )
        await self.__wait_after_action()
    async def __async_click_button_wit4sec_waiting(self, tex, mess = 2):
        messages = await self.__last_messages(quantity=mess)
        button = find_button(messages, tex)
        message = self.__get_last_message()
        event = button.click()
        await asyncio.wait({event, message},return_when='FIRST_COMPLETED' )
        await asyncio.sleep(4)

    async def __async_send_message(self, message):
        await self.client.send_message(self.bot, message)
        await self.__wait_after_action()

    async def __async_get_message(self):
        message = await self.__get_last_message()
        self.message = message.text

    async def __async_get_messages(self, n):
        messages = await self.__last_messages(quantity=n)
        self.messages = messages

    async def __async_check_message(self, search_text, mess_quant=2):
        messages = await self.__last_messages(quantity=mess_quant)
        self.check_text = False
        for message in messages:
            if re.search(pattern=search_text,string=message.text):
                self.check_text = True
                return

    async def __async_check_message_code(self, code):
        messages = await self.__last_messages()
        self.check_text = False
        search_text = find_text_from_table(int(code))
        for message in messages:
            if search_text in message.text:
                self.check_text = True
                return

    async def __async_get_profile_fl_name_username(self):
        profile = await self.client.get_me()
        username = '(@' + profile.username + ')' if profile.username else '()'
        first_name = profile.first_name + ' ' if profile.first_name else ''
        last_name = profile.last_name + ' ' if profile.last_name else ''
        self.profile_data = first_name + last_name + username

    async def __async_button_is_disappeared(self, button_name, mess_quant):
        messages = await self.__last_messages(quantity=mess_quant)
        button = find_button(messages, button_name)
        self.check_disappeared_button = True if button == None else False

    async def __async_immutable_after_click(self, button_name, mess_quant):
        messages = await self.__last_messages(quantity=mess_quant)
        button = find_button(messages, button_name)
        message_before = messages[0].text
        """click the button"""
        cork = self.__get_last_message()
        event = button.click()
        await asyncio.wait({event, cork}, return_when='FIRST_COMPLETED')
        """------------------------------------------------------------"""
        await asyncio.sleep(2)
        messages = await self.__last_messages(quantity=mess_quant)
        message_after = messages[0].text
        self.immutable_after_click_result = True if message_before==message_after else False

    async def __async_send_file(self, file):
        await self.client.send_file(entity=self.bot, file=file, force_document=True)
        await self.__wait_after_action()
    """functions for step files"""
    def click_button(self, tex, mess_quant=2):
        with self.client:
            self.client.loop.run_until_complete(self.__async_click_button(tex, mess_quant))

    def click_button_wit4sec_waiting(self, tex, mess_quant=2):
        with self.client:
            self.client.loop.run_until_complete(self.__async_click_button_wit4sec_waiting(tex, mess_quant))

    def send_message(self, message_text):
        with self.client:
            self.client.loop.run_until_complete(self.__async_send_message(message_text))

    def get_message(self):
        with self.client:
            self.client.loop.run_until_complete(self.__async_get_message())
        return self.message

    def get_messages(self, quantity_mess=2 ):
        with self.client:
            self.client.loop.run_until_complete(self.__async_get_messages(quantity_mess))
            return self.messages

    def check_message(self, search_text,mess_quant=2):
        with self.client:
            self.client.loop.run_until_complete(self.__async_check_message(search_text, mess_quant=mess_quant))
        return self.check_text

    def check_message_code(self, code):
        with self.client:
            self.client.loop.run_until_complete(self.__async_check_message_code(code))
        return self.check_text

    def get_profile_fl_name_username(self):
        """" gives first, last name and username of user"""
        with self.client:
            self.client.loop.run_until_complete(self.__async_get_profile_fl_name_username())
        return self.profile_data

    def button_is_disappeared(self, button_name, mess_quant=2):
        with self.client:
            self.client.loop.run_until_complete(self.__async_button_is_disappeared(button_name, mess_quant=mess_quant))
        return self.check_disappeared_button

    def immutable_after_click(self, button_name, mess_quant=2):
        with self.client:
            self.client.loop.run_until_complete(self.__async_immutable_after_click(button_name, mess_quant=mess_quant))
        return self.immutable_after_click_result

    def send_file(self, file):
        with self.client:
            self.client.loop.run_until_complete(self.__async_send_file(file))
