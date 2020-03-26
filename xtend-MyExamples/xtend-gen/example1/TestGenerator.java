package example1;

import example1.Entity;
import example1.Generator;
import example1.ParseXmlTool;
import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.util.ArrayList;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.InputOutput;

@SuppressWarnings("all")
public class TestGenerator {
  public static void main(final String[] args) {
    try {
      ArrayList<Entity> tableList = ParseXmlTool.parseXml();
      InputOutput.<CharSequence>println(Generator.generateSql(tableList));
      File file = new File("src/example1/User.java");
      FileOutputStream fileOutputStream = new FileOutputStream(file);
      PrintStream printStream = new PrintStream(fileOutputStream);
      System.setOut(printStream);
      InputOutput.<CharSequence>println(Generator.generateClass(tableList));
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
