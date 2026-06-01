# Use official lightweight Python image
FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Copy dependency file first (for Docker layer caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy rest of application code
COPY . .

# Expose port the app runs on
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]
