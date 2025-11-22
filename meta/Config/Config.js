const module = await import('./config.json', { with: { type: 'json' } });

const config = module.default;

export const _config = {
  env: config.env || 'dev',
  googleDriveApiKey: config.googleDriveApiKey || '',
  api: config.api,
  ui: config.ui,
};