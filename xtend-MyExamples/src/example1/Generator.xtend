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
		«FOR e : entities»		
			public class «e.name.toFirstUpper» {
				«FOR f : e.features.entrySet»
«««				注释：f.value.get(0)是type、f.value.get(1)是defaultValue
					«var type = f.value.get(0).generateType»
					private «type» «f.key»;
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
			«f.key» «f.value.get(0)»
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
	HashMap<String, ArrayList<String>> features
}