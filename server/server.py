import asyncio
import websockets
import json

ip = "0.0.0.0"
port = 8080

players = {}

class Lobby():

    lobbies = []

    def __init__(self, host):
        self.host = host
        self.members = [(host, players[host])]
        self.blackScreenLocks = [False]
        Lobby.lobbies.append(self)
        self.codeRequired = False
        self.turn = 0
    
    def getLobbyText(self):
        text = ""
        for i in self.members:
            text += i[1] + "\n"
        return text

    def getUsernames(self):
        u = []
        for i in self.members:
            u.append(i[1])
        return json.dumps(u)

    def isAnyLocked(self):
        for i in self.blackScreenLocks:
            if i:
                return True
        return False
    
    async def joinLobby(self, player):
        self.members.append((player, players[player]))
        self.blackScreenLocks.append(False)
        await self.sendLobby()
    
    async def sendLobby(self):
        await self.msgAllOthers(f"Lobby:{self.getLobbyText()}", None)

    async def sendTurn(self, nextTurn = True):
        if nextTurn:
            self.turn += 1
            if self.turn == len(self.members):
                self.turn = 0
        user = self.members[self.turn][1]
        for i in range(len(self.members)):
            await self.members[i][0].send(f"Turn:{user}")
    
    async def lock(self, ws):
        ind = 0
        for num, i in enumerate(self.members):
            if i[0] == ws:
                ind = num
                break
        self.blackScreenLocks[num] = True
        if self.blackScreenLocks[self.turn] == False:
            await self.members[self.turn][0].send("Lock")
    
    async def unlock(self, ws):
        ind = 0
        for num, i in enumerate(self.members):
            if i[0] == ws:
                ind = num
                break
        self.blackScreenLocks[num] = False
        if not self.isAnyLocked():
            for i in self.members:
                await i[0].send("Unlock")

    
    async def startGame(self):
        for i in self.members:
            await i[0].send(f"PlayerCount:{len(self.members)}")
            await i[0].send(f"PlayerNames:{self.getUsernames()}")
        await self.sendTurn(False)

    async def sendDeckCode(self, code):
        for i in range(1, len(self.members)):
            await self.members[i][0].send(code)

    async def msgAllOthers(self, msg, ws=None):
        for i in self.members:
            if i[0] != ws:
                await i[0].send(msg)

async def parseMsg(websocket, message):
    if message == "ping":
        # players.append(websocket)
        await websocket.send(f"Pong")
    elif message == "Create Lobby":
        Lobby(websocket)
        await websocket.send(f"Lobby Created")
    elif message == "Join Lobby":
        await Lobby.lobbies[0].joinLobby(websocket)
    elif message == "Start Game":
        await Lobby.lobbies[0].startGame()
    elif message == "End Turn":
        await Lobby.lobbies[0].sendTurn(True)
    elif message == "Rewind Turn":
        await Lobby.lobbies[0].sendTurn(False)
    elif message.startswith("Uname:"):
        uname = message[message.index(":") + 1:]
        players[websocket] = uname
    elif message == "BlackscreenLock":
        await Lobby.lobbies[0].lock(websocket)
    elif message == "BlackscreenUnlock":
        await Lobby.lobbies[0].unlock(websocket)
    else:
        await Lobby.lobbies[0].msgAllOthers(message, websocket)


async def handleMessage(websocket):
    async for message in websocket:
        print(f"Received from client: '{message}'")
        await parseMsg(websocket, message)
        

async def main():
    # The 'serve' function creates a server on the specified host and port.
    async with websockets.serve(handleMessage, ip, port):
        await asyncio.Future() # Run forever

if __name__ == "__main__":
    print(f"WebSocket server running on ws://{ip}:{port}")
    asyncio.run(main())