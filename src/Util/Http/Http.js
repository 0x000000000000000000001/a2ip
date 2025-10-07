import { isNode } from '../Util.Env/index.js'

let driverModule;

if (isNode) driverModule = await import('../Affjax.Node/index.js');
else driverModule = await import('../Affjax.Web/index.js'); // We don't import Affjax Node in the browser (in purs or js, because xhr2 would not be accepted)

export const driver = driverModule.driver;