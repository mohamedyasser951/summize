from flask import Flask, jsonify ,request
from sumy.parsers.plaintext import PlaintextParser
from sumy.nlp.tokenizers import Tokenizer
from sumy.summarizers.text_rank import TextRankSummarizer
import re


# summery
def summeryText(text):
    parser = PlaintextParser.from_string(text,Tokenizer("arabic"))
    summarizer_4 = TextRankSummarizer()
    summary =summarizer_4(parser.document , 10)
    text_summary=""
    for sentence in summary:
        text_summary+=str(sentence)
    return text_summary


app = Flask(__name__)

@app.route('/example_endpoint')
def example_endpoint():
    text = request.args.get('parameter_name')
    suma_text = summeryText(text)

    final_text = re.sub('[^ء-ي ]+', '', suma_text)

    data = {"data": final_text}
    return jsonify(data)

if __name__ == '__main__':
    app.run(host='0.0.0.0' , port=5000)


#"http://192.168.1.3:5000/example_endpoint?parameter_name=$text";


# def replace_english_numbers_to_arabic(text):
#     arabic_numbers = {
#         '0': '٠', '1': '١', '2': '٢', '3': '٣', '4': '٤',
#         '5': '٥', '6': '٦', '7': '٧', '8': '٨', '9': '٩'
#     }

#     def replace_match(numbers):
#         return arabic_numbers[numbers.group(0)]

#     return re.sub(r'[0-9]', replace_match, text)




