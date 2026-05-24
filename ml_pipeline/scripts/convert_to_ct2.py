import os
import argparse
import ctranslate2
import transformers
from sentencepiece import SentencePieceProcessor

def convert_model(model_name_or_path, output_dir, quantization="int8", force=False):
    """
    Convert a Hugging Face translation model to CTranslate2 format.
    """
    if os.path.exists(output_dir) and not force:
        print(f"Output directory {output_dir} already exists. Use --force to overwrite.")
        return False

    print(f"Converting model '{model_name_or_path}' to CTranslate2 format...")
    print(f"Quantization mode: {quantization}")
    print(f"Destination: {output_dir}")

    try:
        # Check model type to use the appropriate converter
        # We generally use NLLB-200 or Marian/Opus-MT architectures
        converter = ctranslate2.converters.TransformersConverter(
            model_name_or_path,
            copy_files=["tokenizer.json", "vocab.json", "sentencepiece.model"]
        )
        
        converter.convert(
            output_dir,
            quantization=quantization,
            force=force
        )
        
        print("Model conversion completed successfully!")
        
        # Display the generated files and their sizes
        print("\nGenerated files:")
        for file in os.listdir(output_dir):
            file_path = os.path.join(output_dir, file)
            size_mb = os.path.getsize(file_path) / (1024 * 1024)
            print(f"  - {file} ({size_mb:.2f} MB)")
            
        return True
    except Exception as e:
        print(f"Error during model conversion: {e}")
        return False

def main():
    parser = argparse.ArgumentParser(description="Convert Hugging Face models to CTranslate2 format.")
    parser.add_argument(
        "--model", 
        type=str, 
        required=True,
        help="Hugging Face model ID or path to local model (e.g., 'facebook/nllb-200-distilled-600M' or 'Helsinki-NLP/opus-mt-en-hi')"
    )
    parser.add_argument(
        "--output", 
        type=str, 
        required=True, 
        help="Path to output directory for the CTranslate2 model"
    )
    parser.add_argument(
        "--quantization", 
        type=str, 
        default="int8",
        choices=["int8", "int8_float16", "int16", "float16", "float32"],
        help="Weight quantization precision (default: int8)"
    )
    parser.add_argument(
        "--force", 
        action="store_true", 
        help="Overwrite output directory if it already exists"
    )

    args = parser.parse_args()
    convert_model(
        model_name_or_path=args.model,
        output_dir=args.output,
        quantization=args.quantization,
        force=args.force
    )

if __name__ == "__main__":
    main()
