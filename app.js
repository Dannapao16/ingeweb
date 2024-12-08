const express = require('express');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.urlencoded({ extended: true })); // Parse datos de formularios
app.use(bodyParser.json()); // Parse datos en formato JSON



app.use(express.urlencoded({extended:false}));
app.use(express.json());

const dotenv = require('dotenv');
dotenv.config({path:'./env/.env'});

app.use('/resources', express.static('public'));
app.use('/resources', express.static(__dirname + '/public'));

app.set('view engine', 'ejs');

const bcryptjs = require('bcryptjs');

const session = require('express-session');

app.use(session({
    secret:'secret',
    resave: 'true',
    saveUninitialized: true
}));

// invocar al modulo de la conexion de la BD
 const connection= require('./database/db');
//establecer las rutas
app.get('/', (req, res) => {
    res.render('index');
});

app.get('/login', (req, res) => {
    res.render('login');
});

app.get('/register', (req, res) => {
    res.render('register');
});

app.post('/register', async (req, res) => {
    const { Nombre, Apellido, Email, Contrasena, TipoUsuario } = req.body;

    try {
        // Hashear la contraseña
        const hashedPassword = await bcryptjs.hash(Contrasena, 8);

        // Insertar datos en la tabla
        const query = `
            INSERT INTO Usuarios (Nombre, Apellido, Email, Contrasena, TipoUsuario)
            VALUES (?, ?, ?, ?, ?)
        `;
        connection.query(query, [Nombre, Apellido, Email, hashedPassword, TipoUsuario], (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).send('Error al registrar el usuario');
            } else {
                res.render('register',{
                    alert:true,
                    alertTitle: 'Registration',
                    alertMessage: '¡Registro exitoso!',
                    alertIcon: 'sucess',
                    showConfirmButton: false,
                    timer:3000,
                    ruta:""

                });
            }
        });
    } catch (error) {
        console.error(error);
        res.status(500).send('Error del servidor');
    }
});

app.post('/auth', async (req, res) => {
    const { Email, Contrasena } = req.body;

    // Validar que los campos no estén vacíos
    if (!Email || !Contrasena) {
        return res.status(400).send('Por favor ingrese correo y contraseña');
    }

    try {
        connection.query('SELECT * FROM Usuarios WHERE Email = ?', [Email], async (error, results) => {
            if (error) {
                console.error(error);
                return res.status(500).send('Error del servidor');
            }

            // Verificar si el usuario existe
            if (results.length === 0) {
                return res.status(401).send('El usuario o la contraseña son incorrectos');
            }

            const user = results[0];

            // Verificar la contraseña
            const passwordMatch = await bcryptjs.compare(Contrasena, user.Contrasena);
            if (!passwordMatch) {
                // Mostrar alerta de error con SweetAlert
                return res.render('login', {
                    alert: true,
                    alertTitle: "Error",
                    alertMessage: "Usuario y/o Contraseña incorrectas",
                    alertIcon: "error",
                    showConfirmButton: true,
                    timer: 3000,
                    ruta: 'login'
                });
            }

            // Si la contraseña es correcta, establecer la sesión y mostrar el login exitoso
            req.session.Nombre = user.Nombre;

            // Mostrar alerta de éxito con SweetAlert
            return res.render('login', {
                alert: true,
                alertTitle: "Conexión Exitosa",
                alertMessage: "¡Login Correcto!",
                alertIcon: "success",
                showConfirmButton: false,
                timer: 3000,
                ruta: ''
            });
        });
    } catch (error) {
        console.error(error);
        return res.status(500).send('Error del servidor');
    }
});



app.listen(3000, () => {
    console.log('Server running in http://localhost:3000'); 
});
