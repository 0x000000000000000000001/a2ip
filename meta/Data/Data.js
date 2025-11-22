const module = await import('./data.json', { with: { type: 'json' } });

export const _data = module.default;