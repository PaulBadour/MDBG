import asyncio
import websockets

players = []

class Lobby():

    lobbies = []

    def __init__(self, host):
        self.host = host
        self.members = [(host, "host")]
        Lobby.lobbies.append(self)
        self.codeRequired = False
        self.turn = 0
    
    async def joinLobby(self, player):
        self.members.append((player, "joiner"))
        await self.host.send(f"Player joined the lobby")

    async def sendTurn(self, nextTurn = True):
        if nextTurn:
            self.turn += 1
            if self.turn == len(self.members):
                self.turn = 0
        user = self.members[self.turn][1]
        for i in range(len(self.members)):
            await self.members[i][0].send(f"Turn:{user}")
    
    async def startGame(self):
        for i in self.members:
            await i[0].send(f"PlayerCount:{len(self.members)}")
        await self.sendTurn(False)

    async def sendDeckCode(self, code):
        for i in range(1, len(self.members)):
            await self.members[i][0].send(code)

async def handleMessage(websocket):
    async for message in websocket:
        print(f"Received from client: '{message}'")
        if message == "ping":
            players.append(websocket)
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
        elif message.startswith("HeroDeck") or message.startswith("VillainDeck"):
            await Lobby.lobbies[0].sendDeckCode(message)
        

async def main():
    # The 'serve' function creates a server on the specified host and port.
    async with websockets.serve(handleMessage, "localhost", 9080):
        await asyncio.Future() # Run forever

if __name__ == "__main__":
    print("WebSocket server running on ws://localhost:9080")
    asyncio.run(main())