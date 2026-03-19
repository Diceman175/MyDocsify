const apiKey = 'YOUR_API_KEY'; // Replace with your actual API key
const cities = ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix'];
const weatherContainer = document.getElementById('weather-container');

async function fetchWeather(city) {
    const response = await fetch(`https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=imperial`);
    if (!response.ok) {
        throw new Error('Weather data not found');
    }
    return response.json();
}

function displayWeather(data) {
    const cityWeather = document.createElement('div');
    cityWeather.classList.add('city-weather');
    cityWeather.innerHTML = `
        <h2>${data.name}</h2>
        <p>Temperature: ${data.main.temp} °F</p>
        <p>Weather: ${data.weather[0].description}</p>
    `;
    weatherContainer.appendChild(cityWeather);
}

async function loadWeather() {
    try {
        for (const city of cities) {
            const weatherData = await fetchWeather(city);
            displayWeather(weatherData);
        }
    } catch (error) {
        console.error(error);
        weatherContainer.innerHTML = '<p>Error fetching weather data.</p>';
    }
}

document.addEventListener('DOMContentLoaded', loadWeather);