import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
    base: '/',
    plugins: [react()],
    build: {
      outDir: './build',
    },
    server: {    
        open: true,
        port: 3000, 
    },
})
