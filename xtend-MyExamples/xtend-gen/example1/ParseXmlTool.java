package example1;

import example1.Entity;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.eclipse.xtext.xbase.lib.Exceptions;

@SuppressWarnings("all")
public class ParseXmlTool {
  public static ArrayList<Entity> parseXml() {
    try {
      final ArrayList<Entity> entities = new ArrayList<Entity>();
      final SAXReader reader = new SAXReader();
      File _file = new File("src/table.xml");
      final Document document = reader.read(_file);
      final Element root = document.getRootElement();
      final List tableNodes = root.elements("table");
      for (final Object t : tableNodes) {
        {
          Element tableNode = ((Element) t);
          String tableId = tableNode.attributeValue("id");
          List fieldNodes = tableNode.elements("field");
          HashMap<String, String> map = new HashMap<String, String>();
          for (final Object f : fieldNodes) {
            {
              Element fieldNode = ((Element) f);
              String name = fieldNode.attributeValue("name");
              String datatype = fieldNode.attributeValue("datatype");
              map.put(name, datatype);
            }
          }
          Entity entity = new Entity(tableId, map);
          entities.add(entity);
        }
      }
      return entities;
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
