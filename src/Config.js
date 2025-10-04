import dotenv from 'dotenv';

let isLoaded = false;

const loadDotEnv = () => {
  if (isLoaded) {
    return;
  }

  const result = dotenv.config();
  
  if (result.error) {
    console.error('❌ Could not load .env file:', result.error.message);
  } 
  
  isLoaded = true;
};

export const lookupEnv = (key) => () => {
  if (!isLoaded) {
    loadDotEnv();
  }

  const value = process.env[key];
  return value === undefined ? "" : value;
};