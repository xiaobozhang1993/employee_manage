import JsEncrypt from 'jsencrypt'

// 实例化一个JSEncrypt对象
let jse = new  JSEncrypt()
jse.setPublicKey('MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC6f66pBZ7wS7+eLOGDpILzyRetEib53ycQ/roudbhCB4nALvzscm6MyjAZoVf4A/V0PU4LjjIaLQVkQ/sO9oxTUKqjCxCdq1go8TALGoKZKkPDhno1On/h7mS0eXTlstHGt1NmDRPhT8Ah+Q5xmCRnTHWfSqHAlW2BkeMfW+GrPQIDAQAB')

export function encrypt(data){
	let encrypted = jse.encrypt(data)
	console.log('en pass ' , encrypted)
	return  encrypted;
}