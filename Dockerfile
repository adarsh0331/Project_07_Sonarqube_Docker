# Use official nginx image
FROM nginx:alpine

# Copy your HTML file(s) into nginx's default directory
COPY ./index.html /usr/share/nginx/html/

# Expose port 80 inside container
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
