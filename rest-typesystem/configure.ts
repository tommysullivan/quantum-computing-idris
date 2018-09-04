export interface Configuration {
    value: string
}
export type Configurer = ()=>Promise<Configuration>
export const configure = (configurer:Configurer)=>any
export const configuration = (definition:Configuration)=>Promise<void>

configure(async ()=>({
    value: "test config"
}));

const staticConfiguration