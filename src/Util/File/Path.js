import { isNode } from '../Util.Env/index.js'

const beforeOutput = import.meta.url.split('/output/')[0];

export const rootDirAbsolutePath = (isNode ? beforeOutput.split('file://')[1] : beforeOutput) + '/';