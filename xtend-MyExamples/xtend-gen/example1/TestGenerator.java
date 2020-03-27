package example1;

import example1.Entity;
import example1.Generator;
import example1.ParseXmlTool;
import java.util.ArrayList;
import org.eclipse.xtext.xbase.lib.InputOutput;

@SuppressWarnings("all")
public class TestGenerator {
  public static void main(final String[] args) {
    ArrayList<Entity> tableList = ParseXmlTool.parseXml();
    InputOutput.<CharSequence>println(Generator.generateClass(tableList));
    InputOutput.<CharSequence>println(Generator.generateSql(tableList));
  }
}
