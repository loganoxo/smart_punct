# smart_punct

## 说明  
- 作用: 在中文输入法下，自动将中文标点替换为英文标点
- 解决的问题:
  -   在只使用mac原生输入法时, 当切换到中文输入法时, 按下引号等符号键时,会输入中文的标点(如: ” ， 。 等) 而不是 英文的标点( " , . )
  -   中文输入法中有一个选项为"使用半角标点符号", 开启这个后中文输入法下的逗号或句号会变为英文的, 但是不够全, 比如依然还会输入 中文的单引号和双引号
  -   用这个脚本配合 hammerspoon使用, 再加上 OnlySwitch(可选); 就能完美解决中文输入法下要输入全英文标点符号时的问题了
- 效果:
  -   几乎无延迟,我用着还挺顺手的,因为并不是使用切换输入法的方式来做的(这个方案试过一下,效果很差)
  -   不影响 ctrl cmd option fn + 符号键 的快捷键
  -   兼容 中文输入法下的 是否选中 "使用半角标点符号"的选项 的两种情况

## 使用方式
```shell
cd ~
git clone https://github.com/loganoxo/smart_punct.git ./.hammerspoon
brew install hammerspoon  #默认会创建 /opt/homebrew/bin/hs

# 打开hammerspoon会自动加载脚本,自动开启智能标点
# 也可以用如下方式手动管理
# 开启:    /opt/homebrew/bin/hs -c 'Smart_Punct_Start()'
# 关闭:    /opt/homebrew/bin/hs -c 'Smart_Punct_Stop()'
# 状态:    /opt/homebrew/bin/hs -c 'Smart_Punct_Status()'

```

## 菜单栏

- 虽然hammerspoon有菜单栏的api, 但是感觉效果很差
- 用 OnlySwitch 添加一个菜单开关, 体验感会更好

### 效果: 
<img width="633" alt="SCR-20250424-sohk" src="https://github.com/user-attachments/assets/f8d37526-3ab7-4657-930e-c217046a5bcc" />

### 方法步骤:

- 1、 添加一个 Evolution

<img width="604" alt="SCR-20250424-spab" src="https://github.com/user-attachments/assets/f2e9f6af-e4ea-4062-ab4c-422e43a94c12" />

- 2、填入
<img width="772" alt="image" src="https://github.com/user-attachments/assets/d81b1454-78f5-4a68-b203-a9917761cc3c" />

<img width="788" alt="image" src="https://github.com/user-attachments/assets/632854f0-be62-4fba-8201-34faf9b99656" />

```shell
/opt/homebrew/bin/hs -c 'Smart_Punct_Start()'   # 开启
/opt/homebrew/bin/hs -c 'Smart_Punct_Stop()'    # 关闭
/opt/homebrew/bin/hs -c 'Smart_Punct_Status()'  # 状态
# 输出: 1
```

- 3、三个按钮执行成功后方可保存





















