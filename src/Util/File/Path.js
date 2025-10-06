import { isNode } from '../Util.Env/index.js'

export const rootDirPath = isNode ? import.meta.url.split('file://')[1].split('/output/')[0] + '/' : '/';