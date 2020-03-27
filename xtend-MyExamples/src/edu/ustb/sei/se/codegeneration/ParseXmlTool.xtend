package edu.ustb.sei.se.codegeneration
/**
 * dom4j解析xml文件
 * 记得导入dom4j-1.6.1.jar
 */
import java.util.ArrayList
import org.dom4j.io.SAXReader
import java.io.File
import org.dom4j.Element

class ParseXmlTool {
	
	def parseXml(String path){
		// 先准备保存实体对象的列表
		val entities = new ArrayList<Entity>
		
		// 读取xml文件，获得Document对象
		val reader = new SAXReader	
		val document = reader.read(new File(path))	// 自动抛出异常
		
		// 获得文档的根节点
		val root = document.rootElement
		
		// 获取根节点下所有名为"table"的子结点，并进行遍历
		val tableNodes = root.elements("table")
		for(t : tableNodes){ 
			val tableNode = t as Element // 强制转换
			
			// 获取table节点的id属性值
			val tableName = tableNode.attributeValue("id")
			
			// 获得table节点下所有名为"field"的子结点
			val fieldNodes = tableNode.elements("field")
						
			// 遍历所有field节点，获取每个field节点的name属性值、datatype属性值和defaultValue属性值
			val features = new ArrayList<Feature>
			for(f : fieldNodes){
				val fieldNode = f as Element 
				val name = fieldNode.attributeValue("name")
				val datatype = fieldNode.attributeValue("datatype")
				val defaultValue = fieldNode.attributeValue("defaultValue")
				val feature = new Feature(name,datatype,defaultValue);
				features += feature
			}
			
			val entity = new Entity(tableName, features)
			entities.add(entity)
		}
		return entities 		
	}	
}