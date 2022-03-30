<template>
  <div class="my-10">
    <form @submit.prevent="submit">
        <div class="shadow overflow-hidden sm:rounded-md">
        <div class="px-4 py-5 bg-white sm:p-6">
          <div class="grid grid-cols-6 gap-6">
            <div class="col-span-6 sm:col-span-3">
                <label for="cliente" class="block text-sm font-medium text-gray-700">Cliente</label>
                <select id="cliente" name="cliente" class="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-gray-500 focus:border-gray-500 sm:text-sm">
                <option>United States</option>
                <option>Canada</option>
                <option>Mexico</option>
                </select>
            </div>

            <div class="col-span-6 sm:col-span-3">
              <label
                for="monto"
                class="block text-sm text-gray-700"
                >Monto</label
              >
              <input
                type="text"
                name="monto"
                id="monto"
                autocomplete="off"
                class="
                  mt-1                  
                  block
                  w-full
                  shadow-sm
                  sm:text-sm
                  border-gray-700
                  rounded-md
                "
              />
            </div>
          </div>
        </div>
        <div class="px-4 py-3 bg-gray-50 text-right sm:px-6">
          <button
            type="submit"
            class="
              inline-flex
              justify-center
              py-2
              px-4
              border border-transparent
              shadow-sm
              text-sm              
              rounded-md
              text-white
              bg-blue-600
              hover:bg-blue-700
              focus:outline-none
            "
          >
            Save
          </button>
        </div>
      </div>
    </form>
  </div>
  <div class="relative overflow-x-auto sm:rounded-lg">
      <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
          <tr>
            <th scope="col" class="px-6 py-3">Cliente</th>
            <th scope="col" class="px-6 py-3">Monto</th>
            <th scope="col" class="px-6 py-3">
              <span class="sr-only"></span>
            </th>
          </tr>
        </thead>
        <tbody>
          <tr class="bg-white border-b">
            <th scope="row" class="px-6 py-4 whitespace-nowrap">
              1
            </th>
            <td class="px-6 py-4">200</td>
            <td class="px-6 py-4 text-right">
              <a href="#" class="text-blue-600 dark:text-blue-500 hover:underline"></a>
            </td>
          </tr>
        </tbody>
      </table>
    </div>  
</template>

<script>
export default {
  name: "FormPago",
  setup() {
      const submit = () => {
          console.log('submit form');
      }
  }
};
</script>