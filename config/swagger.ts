import swaggerJsdoc from 'swagger-jsdoc';

const options: swaggerJsdoc.Options = {
    definition: {
        openapi: '3.0.0',
        info: {
            title: 'Backend Caffeine API',
            version: '1.0.0',
            description: 'Dokumentasi API lengkap untuk aplikasi Backend Caffeine, termasuk untuk Admin dan Kasir.',
        },
        servers: [
            {
                url: 'http://localhost:3000', // Ganti dengan URL server Anda
                description: 'Development server',
            },
        ],
        components: {
            securitySchemes: {
                cookieAuth: {
                    type: 'apiKey',
                    in: 'cookie',
                    name: 'connect.sid', // Nama cookie session Anda, sesuaikan jika berbeda
                },
            },
        },
        security: [
            {
                cookieAuth: [],
            },
        ],
    },
    apis: ['./routes/**/*.ts'], // Path ke file API routes Anda
};

const swaggerSpec = swaggerJsdoc(options);

export default swaggerSpec;
