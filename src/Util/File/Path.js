import { isNode } from '../Util.Env/index.js'

const beforeOutput = import.meta.url.split('/output/')[0];

export const rootDirPath = isNode ? beforeOutput.split('file://')[1] : beforeOutput;