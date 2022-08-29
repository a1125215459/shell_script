#!/bin/bash
#接收用户输入的数字，然后从1加到这个数字

function sum () {
	#定义函数sum
		s=0
			for (( i=0; i<=$num;i=i+1 ))
					#循环直到i大于$1为止。$1是函数sum 的第一个参数
							#在函数中也可以使用位置参数变量，不过这里的$1指的是函数的第一个参数
									do
												s=$(( $i+$s ))
														done
															echo "The sum of 1+2+3...+$1 is :$s"
																#输出1加到$1的和
																}

																read -p "Please input a number: " -t 30 num
																#接收用户输入的数字，并把值赋予变量num
																y=$(echo $num | sed 's/[0-9]//g')
																#把变量num的值替换为空，并赋予变量y

																if [ -z "$y"]
																#判断变量y是否为空，以确定变量num中是否为数字
																	then
																			sum $num
																					#调用sum函数，并把变量num的值作为第一个参数传递给sum函数
																					else
																							echo "Error!! Please input a number!"
																									#如果变量num 的值不是数字，则输出报错信息
																									fi
