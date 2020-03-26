package example1
/**
 * dom4j解析xml文件
 * 记得导入dom4j-1.6.1.jar
 */
import java.util.ArrayList
import org.dom4j.io.SAXReader
import java.io.File
import org.dom4j.Element
import java.util.HashMap

class ParseXmlTool {
	
	def static parseXml(){
		// 先准备保存实体对象的列表
		val entities = new ArrayList<Entity>
		
		// 读取xml文件，获得Document对象
		val reader = new SAXReader	
		val document = reader.read(new File("src/table.xml"))	// 自动抛出异常
		
		// 获得文档的根节点
		val root = document.rootElement
		
		// 获取根节点下所有名为"table"的子结点，并进行遍历
		val tableNodes = root.elements("table")
		for(t : tableNodes){ 
			var tableNode = t as Element // 强制转换
			
			// 获取table节点的id属性值
			var tableId = tableNode.attributeValue("id")
			
			// 获得table节点下所有名为"field"的子结点
			var fieldNodes = tableNode.elements("field")
						
			// 遍历所有field节点，获取每个field节点的name属性值和datatype属性值
			var map = new HashMap<String, String>	// 准备保存features的map
			for(f : fieldNodes){
				var fieldNode = f as Element 
				var name = fieldNode.attributeValue("name")
				var datatype = fieldNode.attributeValue("datatype")
				map.put(name, datatype)
			}
			
			var entity = new Entity(tableId, map)
			entities.add(entity)
		}
		return entities 		
	}	
}