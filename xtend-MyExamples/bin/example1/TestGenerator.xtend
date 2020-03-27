package example1

class TestGenerator {
	
	def static void main(String[] args) {

		var tableList = ParseXmlTool.parseXml()	// 变量的类型可以从右边表达式推断出来
		
		println(Generator.generateClass(tableList))
		
		println(Generator.generateSql(tableList))
		
	}
}