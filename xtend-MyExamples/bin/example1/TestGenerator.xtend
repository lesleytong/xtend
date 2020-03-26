package example1

import java.io.File
import java.io.FileOutputStream
import java.io.PrintStream

class TestGenerator {
	
	def static void main(String[] args) {

		var tableList = ParseXmlTool.parseXml()	// 变量的类型可以从右边表达式推断出来
		
		println(Generator.generateSql(tableList))
		
		// 将控制台有关类的信息输出到文件
		var file = new File("src/example1/User.java")
		var fileOutputStream = new FileOutputStream(file)
		var printStream = new PrintStream(fileOutputStream)
		System.setOut(printStream)	// 默认到控制台这里，保存到文件。刷新工程可看见相应文件。
		
		println(Generator.generateClass(tableList))
		
	}
}