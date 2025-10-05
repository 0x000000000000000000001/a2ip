const module = await import('./config.json', { with: { type: 'json' } });
const config = module.default;

export const _config = {
  env: config.env || 'dev',
};