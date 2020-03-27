package edu.ustb.sei.se.codegeneration

import java.util.List

/**
 * 代码生成器的示范。这个代码生成器读入一个XML文档中的信息，然后根据这个信息产生Java代码和SQL代码。
 * 代码生成的入口函数是generate()。
 */
class Generator {
	
	/**
	 * 在真实场景下，我们会将输出的代码直接保存为源文件或相应的形式。
	 * 在这个例子中，我们直接输出到控制台。
	 */
	def generate(List<Entity> entities) {
		println(generateClass(entities))
		println(generateSql(entities))
	}
		
	/*
	 * TODO: 扩展1：实现构造函数的生成，在其中进行数据初始化。根据field的defaultValueLiteral值去设置
	 * TODO: 扩展2：实现属性的get、set方法的生成
	 * TODO: 扩展3：实现向数据库插入当前对象的函数
	 */
	def generateClass(List<Entity> entities)'''
		«FOR e : entities»
			public class «e.name.toFirstUpper» {
				«FOR field : e.features»
					private «field.type.generateType» «field.name.toLowerCase»;
				«ENDFOR»			
			}
		«ENDFOR»
	'''
	
	def static generateType(String type){ 
		switch type {
			case 'int': 'int' // 双引号或单引号都表示字符串
			case type.startsWith('varchar'): 'String'
			// 你可以增加自己的类型
			default: 'Object'
		}
	}
			
	def generateSql(List<Entity> entities)'''
		«FOR e : entities»
		CREATE TABLE «e.name»
		(
		«FOR field : e.features SEPARATOR ',' »
			«field.name» «field.type»
		«ENDFOR»
		);
		«ENDFOR»
	'''	
}