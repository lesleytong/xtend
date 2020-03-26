package example1;

import example1.Entity;
import java.util.ArrayList;
import java.util.Map;
import java.util.Set;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.StringExtensions;

@SuppressWarnings("all")
public class Generator {
  /**
   * 扩展1：类模板增加构造函数，实现数据初始化。根据field的defaultValue属性值去设置
   * 
   * 扩展2：类模板增加get、set方法
   */
  public static CharSequence generateClass(final ArrayList<? extends Entity> entities) {
    StringConcatenation _builder = new StringConcatenation();
    {
      boolean _hasElements = false;
      for(final Entity e : entities) {
        if (!_hasElements) {
          _hasElements = true;
          _builder.append("package example1;\n\npublic ");
        }
        _builder.append("class ");
        String _firstUpper = StringExtensions.toFirstUpper(e.getName());
        _builder.append(_firstUpper);
        _builder.append(" {");
        _builder.newLineIfNotEmpty();
        {
          Set<Map.Entry<String, String>> _entrySet = e.getFeatures().entrySet();
          for(final Map.Entry<String, String> f : _entrySet) {
            _builder.append("\t");
            _builder.append("private ");
            String _generateType = Generator.generateType(f.getValue());
            _builder.append(_generateType, "\t");
            _builder.append(" ");
            String _key = f.getKey();
            _builder.append(_key, "\t");
            _builder.append(";");
            _builder.newLineIfNotEmpty();
          }
        }
        _builder.append("}");
        _builder.newLine();
      }
    }
    return _builder;
  }
  
  public static String generateType(final String type) {
    String _switchResult = null;
    boolean _matched = false;
    boolean _contains = type.contains("int");
    if (_contains) {
      _matched=true;
      _switchResult = "int";
    }
    if (!_matched) {
      boolean _contains_1 = type.contains("varchar");
      if (_contains_1) {
        _matched=true;
        _switchResult = "String";
      }
    }
    return _switchResult;
  }
  
  public static CharSequence generateSql(final ArrayList<? extends Entity> entities) {
    StringConcatenation _builder = new StringConcatenation();
    {
      for(final Entity e : entities) {
        _builder.append("CREATE TABLE ");
        String _name = e.getName();
        _builder.append(_name);
        _builder.newLineIfNotEmpty();
        _builder.append("(");
        _builder.newLine();
        {
          Set<Map.Entry<String, String>> _entrySet = e.getFeatures().entrySet();
          boolean _hasElements = false;
          for(final Map.Entry<String, String> f : _entrySet) {
            if (!_hasElements) {
              _hasElements = true;
            } else {
              _builder.appendImmediate(",", "");
            }
            String _key = f.getKey();
            _builder.append(_key);
            _builder.append(" ");
            String _value = f.getValue();
            _builder.append(_value);
            _builder.newLineIfNotEmpty();
          }
        }
        _builder.append(");");
        _builder.newLine();
      }
    }
    return _builder;
  }
}
