package example1

import java.util.HashMap
import java.util.ArrayList

class Generator {
		
	/*
	 * 扩展1：类模板增加构造函数，实现数据初始化。根据field的defaultValue属性值去设置
	 * 
	 * 扩展2：类模板增加get、set方法
	 */
	def static generateClass(ArrayList<? extends Entity> entities)'''
		«FOR e : entities BEFORE 'package example1;\n\npublic '»
			class «e.name.toFirstUpper» {
				«FOR f : e.features.entrySet»
					private «f.value.generateType» «f.key»;
				«ENDFOR»			
			}
		«ENDFOR»
	'''
	
	def static generateType(String type){ 
		switch type{
			case type.contains('int'): 'int' // 双引号或单引号都表示字符串
			case type.contains('varchar'): 'String'
		}
	}
	

	def static generateSql(ArrayList<? extends Entity> entities)'''
		«FOR e : entities»
		CREATE TABLE «e.name»
		(
		«FOR f : e.features.entrySet SEPARATOR ',' »
			«f.key» «f.value»
		«ENDFOR»
		);
		«ENDFOR»
	'''
	
	/*
	 * 扩展3：向表中插入记录的SQL语句的方法
	 */
	
	
	
}


@Data class Entity {
	String name
	HashMap<String, String> features
}
