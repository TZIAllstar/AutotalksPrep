# Use Python base image
FROM python:3.9-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Add Microsoft's GPG key and Edge repository
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
    && mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list \
    && apt-get update \
    && apt-get install -y microsoft-edge-stable

# Install Edge WebDriver
RUN wget -O /tmp/msedgedriver.zip https://msedgedriver.azureedge.net/134.0.3124.83/edgedriver_linux64.zip \
    && unzip /tmp/msedgedriver.zip -d /usr/local/bin/ \
    && rm /tmp/msedgedriver.zip

# Set Edge WebDriver path
ENV PATH="/usr/local/bin:$PATH"

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy test script
COPY TestingWeb_Learning.py /app/TestingWeb_Learning.py

# Set working directory
WORKDIR /app

# Run the script
CMD ["python", "TestingWeb_Learning.py"]
