package edu.ustb.sei.se.codegeneration

class TestGenerator {
	
	def static void main(String[] args) {
		val parser = new ParseXmlTool()
		val tableList = parser.parseXml("src/table.xml")	// 变量的类型可以从右边表达式推断出来
		val generator = new Generator()
		generator.generate(tableList)
	}
}