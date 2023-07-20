const express = require('express');
const app = express();
const cors = require('cors');
const httpServer = require('http').createServer(app);
const io = require('socket.io')(httpServer);
const path = require('path');
const fs = require('fs');
const port = 3001;

app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));
app.use(cors());

app.get('/', (req,res) => {
    const indexPath = path.join(__dirname, '/index.html');
    fs.readFile(indexPath, 'utf8', (err,data) => {
        if(err){
            res.status(500).send("error to connect");
        }
        res.send(data);
    })
})

io.on('connection', socket => {
    console.log('connection on');

    socket.on('message', message => {
        console.log('received message', message);

        io.emit('message', message);
    })

    socket.on('disconnect', () => {
        console.log('disconnect');
    })
});


httpServer.listen(port,() =>{
    console.log(`server connect on port ${port}`);
})
